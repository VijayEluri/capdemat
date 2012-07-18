alter table saintouen_communal_studies_scholarship_request drop constraint FK67AF029AA4AB2F89;
alter table saintouen_communal_studies_scholarship_request drop column account_holder_birth_date;
alter table saintouen_communal_studies_scholarship_request drop column account_holder_first_name;
alter table saintouen_communal_studies_scholarship_request drop column account_holder_last_name;
alter table saintouen_communal_studies_scholarship_request drop column account_holder_title;
alter table saintouen_communal_studies_scholarship_request drop column is_subject_account_holder;
alter table saintouen_communal_studies_scholarship_request drop column bank_account_id;
alter table saintouen_communal_studies_scholarship_request add column nombre_adultes_majeurs int8;
alter table saintouen_communal_studies_scholarship_request add column nombre_enfants_mineurs int8;
alter table saintouen_communal_studies_scholarship_request add column precisions_composition_famille varchar(1024);
alter table saintouen_communal_studies_scholarship_request add column saint_ouen_etablissement_telephone varchar(10);
alter table saintouen_communal_studies_scholarship_request add column vous_vivez_avec varchar(255);

