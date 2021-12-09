DROP TABLE IF EXISTS utilisateur;
DROP TABLE IF EXISTS profil;
DROP TABLE IF EXISTS livrable;
DROP TABLE IF EXISTS documents;
DROP TABLE IF EXISTS projet;
DROP TABLE IF EXISTS phase;
DROP TABLE IF EXISTS permission;


CREATE TABLE public.documents
(
    id_document integer NOT NULL,
    description character varying(255) COLLATE pg_catalog."default",
    chemin character varying(255) COLLATE pg_catalog."default",
    phase_code integer,
    code integer,
    CONSTRAINT documents_pkey PRIMARY KEY (id_document)
);

CREATE TABLE public.livrable
(
    code integer NOT NULL,
    libelle character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    chelin character varying(255) COLLATE pg_catalog."default" NOT NULL,
    projet_code integer NOT NULL,
    CONSTRAINT livrable_pkey PRIMARY KEY (code)
);

CREATE TABLE public.permission
(
    id_permission integer NOT NULL,
    libelle character varying(50) COLLATE pg_catalog."default" NOT NULL,
    description character varying(255) COLLATE pg_catalog."default",
    CONSTRAINT permission_pkey PRIMARY KEY (id_permission)
);

CREATE TABLE public.phase
(
    code integer NOT NULL,
    libelle character varying(255) COLLATE pg_catalog."default" NOT NULL,
    description character varying(50) COLLATE pg_catalog."default" NOT NULL,
    organisme_client character varying(50) COLLATE pg_catalog."default" NOT NULL,
    date_debut date NOT NULL,
    date_fin date NOT NULL,
    prix real,
    stat character varying(50) COLLATE pg_catalog."default",
    etat_factuer boolean,
    etat_paiment boolean,
    CONSTRAINT phase_pkey PRIMARY KEY (code)
);

CREATE TABLE public.profil
(
    id_profil integer NOT NULL,
    libelle character varying(50) COLLATE pg_catalog."default" NOT NULL,
    description character varying(255) COLLATE pg_catalog."default",
    id_permission integer NOT NULL,
    CONSTRAINT profil_pkey PRIMARY KEY (id_profil)
);

CREATE TABLE public.projet
(
    code integer NOT NULL,
    description character varying(255) COLLATE pg_catalog."default" NOT NULL,
    organisme_client character varying(255) COLLATE pg_catalog."default" NOT NULL,
    date_de_debut date NOT NULL,
    date_de_fin date NOT NULL,
    prix real,
    CONSTRAINT projet_pkey PRIMARY KEY (code)
);

CREATE TABLE public.utilisateur
(
    code integer NOT NULL,
    nom character varying(50) COLLATE pg_catalog."default" NOT NULL,
    email character varying(50) COLLATE pg_catalog."default" NOT NULL,
    password character varying(50) COLLATE pg_catalog."default" NOT NULL,
    id_profil integer NOT NULL,
    CONSTRAINT utilisateur_pkey PRIMARY KEY (code)
);


ALTER TABLE public.documents
    ADD CONSTRAINT documents_code_fkey1 FOREIGN KEY (code)
    REFERENCES public.projet (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE public.livrable
    ADD CONSTRAINT livrable_projet_code_fkey FOREIGN KEY (projet_code)
    REFERENCES public.projet (code) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE CASCADE;


ALTER TABLE public.profil
    ADD CONSTRAINT profil_id_permission_fkey FOREIGN KEY (id_permission)
    REFERENCES public.permission (id_permission) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;


ALTER TABLE public.utilisateur
    ADD CONSTRAINT utilisateur_id_profil_fkey FOREIGN KEY (id_profil)
    REFERENCES public.profil (id_profil) MATCH SIMPLE
    ON UPDATE NO ACTION
    ON DELETE NO ACTION;

END;