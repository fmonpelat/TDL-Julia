# TDL-Julia
75.31 - Teoria del Lenguaje FIUBA

![Docker build/push lead image](https://github.com/fmonpelat/TDL-Julia/workflows/Docker%20build/push%20lead%20image/badge.svg?branch=master)

![Docker build/push worker image](https://github.com/fmonpelat/TDL-Julia/workflows/Docker%20build/push%20worker%20image/badge.svg?branch=master)

# Proyecto Integrador
Lenguaje: Julia
Problema práctico: Cálculo de pi mediante el método de Montecarlo

# Introduccion

Repositorio con el código de la presentación sobre Julia. Aquí se encontrará el código usado en los notebooks de la presentación y la configuración de los containers para preparar el ambiente de ejecución.

Presentaciones:

[Presentación inicial y explicación del Método de Montecarlo](Presentación.pdf)

Notebooks por órden de aparición:

[Sintáxis de Julia - Variables](workdir/Sintaxis/1_variables.ipynb)
[Sintáxis de Julia - Estructura de datos](workdir/Sintaxis/2_estructura_de_datos.ipynb)
[Sintáxis de Julia - Aplicación usos prácticos](workdir/Sintaxis/3_aplicacion_usos_practicos.ipynb)
[Sintáxis de Julia - Plots](workdir/Sintaxis/4_plots_copados.ipynb)
[Uso de python en Julia](workdir/uso_de_python_en_julia.ipynb)
[Topología usada](workdir/procesamiento_distribuido_en_julia.ipynb)
[Paralelización del cálculo de Pi](workdir/MonteCarlo/Presentacion Final.ipynb)


# Docker
### Prerequisitos

Se precisa tener instalado docker.

* [Windows](https://docs.docker.com/windows/started)
* [OS X](https://docs.docker.com/mac/started/)
* [Linux](https://docs.docker.com/linux/started/)

## Deployment
--
Construir y dejar en background los containers
```docker-compose -f docker-compose.yml up --build -d```

Acceso al nodo coordinador con acceso a la terminal:
```ssh -p 2022 -o "UserKnownHostsFile=/dev/null" -o "StrictHostKeyChecking=no" root@localhost```

Acceso a Jupyter:

http://localhost:8088

Password: 123456


### Credenciales del container

Usuario:root Contraseña:123456

Usuario:montecarlo (Se accede a los workers por publickey)
