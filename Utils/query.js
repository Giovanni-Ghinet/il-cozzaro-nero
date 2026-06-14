export const queryProduct = `
            select
                p.id, p.name, p.description, p.price, p.country, p.image, 
                p.availability, p.created_at,r.id as id_review, r.author, r.title, 
                r.text, r.valutation, c.name as category
            from products p
                join reviews r
                    on r.id_product = p.id
                join product_category pt
                    on pt.id_product = p.id
                join categories c
                    on c.id = pt.id_category
            order by created_at;
`

export const queryProductCategory = `
            select
                p.id, p.name, p.description, p.price, p.country, p.image, 
                p.availability, p.created_at,r.id as id_review, r.author, r.title, 
                r.text, r.valutation, c.name as category, c.slug
            from products p
                join reviews r
                    on r.id_product = p.id
                join product_category pt
                    on pt.id_product = p.id
                join categories c
                    on c.id = pt.id_category
            where c.slug = ?
            order by created_at;
`



export const queryProductLimit = `
    select 
    p.id, p.name, p.description, p.price, p.country, p.image, p.availability, p.created_at,
    r.id as id_review, r.author, r.title, r.text, r.valutation, 
    c.name as category
    from (
    select * 
    from products 
    order by created_at desc 
    limit ?
    ) p
    join reviews r 
        on r.id_product = p.id
    join product_category pt 
        on pt.id_product = p.id
    join categories c 
        on c.id = pt.id_category
    order by p.created_at desc
`

export const queryProductShow = `
                select p.id, p.name, p.description, p.price, p.country, p.image, p.availability, p.created_at,r.id as id_review, r.author, r.title, r.text, r.valutation, c.name as category
                from products p
                    join reviews r
                        on r.id_product = p.id
                    join product_category pt
                        on pt.id_product = p.id
                    join categories c
                        on c.id = pt.id_category
                where p.id = ?;
            `;



export const queryProductSearch = `
                select
                p.id, p.name, p.description, p.price, p.country, p.image, 
                p.availability, p.created_at,r.id as id_review, r.author, r.title, 
                r.text, r.valutation, c.name as category
                from products p
                    join reviews r
                        on r.id_product = p.id
                    join product_category pt
                        on pt.id_product = p.id
                    join categories c
                        on c.id = pt.id_category
                where p.name like ? or p.description like ?
                order by created_at;
            `;

