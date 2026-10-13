-- Ejecuta este script en Supabase > SQL Editor.
create extension if not exists pgcrypto;

create table if not exists public.publicaciones (
  id uuid primary key default gen_random_uuid(),
  tipo text not null check (tipo in ('analisis','noticia')),
  categoria text not null,
  titulo text not null,
  resumen text not null,
  contenido text not null,
  imagen_url text,
  fuente_url text,
  tecnica text,
  enfermedad text,
  fase text,
  minutos_lectura integer not null default 5 check (minutos_lectura between 1 and 120),
  estado text not null default 'borrador' check (estado in ('borrador','publicado')),
  fecha_publicacion timestamptz,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

alter table public.publicaciones enable row level security;

-- Visitantes anónimos solo pueden leer publicaciones publicadas.
drop policy if exists "Lectura pública de publicaciones publicadas" on public.publicaciones;
create policy "Lectura pública de publicaciones publicadas"
  on public.publicaciones for select
  to anon, authenticated
  using (estado = 'publicado');

-- La administración solo funciona para usuarios autenticados.
-- IMPORTANTE: desactiva el registro público en Authentication > Settings y crea solo la cuenta de la autora.
drop policy if exists "Administración lectura autenticada" on public.publicaciones;
create policy "Administración lectura autenticada"
  on public.publicaciones for select
  to authenticated
  using (true);

drop policy if exists "Administración inserción autenticada" on public.publicaciones;
create policy "Administración inserción autenticada"
  on public.publicaciones for insert
  to authenticated
  with check (true);

drop policy if exists "Administración edición autenticada" on public.publicaciones;
create policy "Administración edición autenticada"
  on public.publicaciones for update
  to authenticated
  using (true)
  with check (true);

drop policy if exists "Administración borrado autenticada" on public.publicaciones;
create policy "Administración borrado autenticada"
  on public.publicaciones for delete
  to authenticated
  using (true);

create index if not exists publicaciones_estado_fecha_idx
  on public.publicaciones (estado, fecha_publicacion desc);
