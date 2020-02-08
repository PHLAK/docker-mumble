#!/usr/bin/env bash
docker-compose down && docker-compose pull --ignore-pull-failures && docker-compose up -d
