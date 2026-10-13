# GenEdit — publicación de noticias y análisis

Esta carpeta contiene una primera adaptación del HTML original de GenEdit, un panel de administración y el esquema de base de datos. La web pública conserva el diseño original. El panel permite iniciar sesión, crear publicaciones, editar, guardar borradores, publicar y eliminar.

## Componentes gratuitos

- **GitHub Pages**: alojamiento de `index.html` y `admin.html`.
- **Supabase Free**: autenticación y base de datos.
- No hace falta un backend propio para este alcance.

Los planes gratuitos y sus límites pueden cambiar; comprobadlos al crear las cuentas.

## Configuración inicial

1. Crea un proyecto en https://supabase.com/.
2. Entra en **SQL Editor**, abre `schema.sql`, pega su contenido y ejecútalo.
3. En **Project Settings → API** (o Connect), copia la Project URL y la clave pública `anon`/publishable.
4. En `index.html` y `admin.html`, sustituye:
   - `PEGA_AQUI_LA_URL_DE_SUPABASE`
   - `PEGA_AQUI_LA_CLAVE_PUBLICA_ANON`
   por los valores del proyecto. La clave pública anon se puede usar en el navegador; **nunca pegues la `service_role` o una clave secreta**.
5. En Supabase **Authentication → Providers/Sign In**, deja activo Email. En **Authentication → Settings**, desactiva los registros públicos. Crea/invita únicamente a la autora como usuario desde el panel de administración de Supabase. Usa una contraseña fuerte.
6. Prueba primero en local sirviendo la carpeta con un servidor estático (por ejemplo, `python -m http.server 8000`) y abre `http://localhost:8000`. No abras los archivos con `file://` para esta prueba.
7. Sube `index.html`, `admin.html` y `schema.sql` al repositorio GitHub. Activa Pages en **Settings → Pages** usando la rama `main` y la carpeta raíz.
8. En Supabase **Authentication → URL Configuration**, añade la URL pública de la web a las URL permitidas. La dirección del panel será `https://TU-USUARIO.github.io/TU-REPOSITORIO/admin.html`.

## Seguridad

- La web pública solo consulta filas con `estado = 'publicado'` gracias a RLS.
- El panel no ofrece registro, solo inicio de sesión.
- Desactiva el registro público en Supabase y crea únicamente la cuenta de la autora.
- Las políticas SQL dan permisos de edición a usuarios autenticados; esto es seguro solo si no permites que cualquiera se registre. Para varios editores, hay que añadir roles y restringir políticas a los usuarios autorizados.
- La URL y la clave anon no son contraseñas. La protección real está en Auth y RLS.

## Funcionamiento

- `admin.html`: panel privado con formulario de publicación.
- `index.html`: sitio público; cuando Supabase está configurado, carga publicaciones reales y deja de usar los ejemplos del HTML para Análisis/Noticias.
- `schema.sql`: tabla `publicaciones` y políticas de seguridad.

## Limitaciones de esta primera versión

- El campo de imagen acepta una URL; todavía no sube ficheros a un almacenamiento propio.
- El contenido completo se presenta como texto con párrafos separados por líneas en blanco; no incluye editor visual enriquecido.
- La suscripción por correo, el foro y los comentarios existentes en el HTML original no se convierten automáticamente en servicios reales.
- La configuración de Supabase debe completarse antes de publicar. Sin credenciales configuradas, la web muestra los datos de demostración originales y el panel no permite entrar.
- Antes de usarla públicamente, revisad accesibilidad, privacidad, enlaces y la información legal correspondiente.
