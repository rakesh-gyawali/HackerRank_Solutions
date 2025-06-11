-- Library Management System

create or replace procedure BorrowBook (
    p_book_id in number,
    p_borrower_id in number,
    p_borrower_name in varchar2
) is
    ERROR_CODE          number(5) := -20000;
    v_available_copies  number;
    v_book_to_borrow    books%rowtype;
    v_borrower          borrowers%rowtype;
    v_borrower_name     borrowers.name%type;
    
begin
    dbms_output.put_line('----- Start BorrowBook -----');


    -- ToDo: need to check whether the data exist using count function!

    -- fetching book data
    select 
        *
    into 
        v_book_to_borrow
    from 
        books
    where bookid = p_book_id;

    DBMS_OUTPUT.PUT_LINE(v_book_to_borrow.title);
    DBMS_OUTPUT.PUT_LINE(v_book_to_borrow.availablecopies);

    -- error if book is not available
    if v_book_to_borrow.availablecopies < 1 then
        raise_application_error(ERROR_CODE, 'The book_id= ' || p_book_id || ' is not available.');

    else 
        -- update books
        UPDATE books
        SET availablecopies = v_book_to_borrow.availablecopies - 1
        WHERE bookid = p_book_id;
        
        if p_borrower_name is null then
            -- fetch borrower's data
            select 
                * 
            into v_borrower
            from borrowers 
            where borrowerid = p_borrower_id
            fetch first 1 row only;

            v_borrower_name := v_borrower.name;

            DBMS_OUTPUT.PUT_LINE(v_borrower.name);
            DBMS_OUTPUT.PUT_LINE(TO_CHAR(SYSDATE, 'MM/DD/YYYY'));

        else 
            v_borrower_name := p_borrower_name;
        end if;

        -- insert borrowers data
        insert into 
            borrowers(BorrowerID, Name, BookID, BorrowedDate)
        values 
            (p_borrower_id, v_borrower_name, p_book_id, TO_CHAR(SYSDATE, 'MM/DD/YYYY'));
    end if;
    
    commit;
exception
    when others then
        rollback;
        if sqlcode = ERROR_CODE then
            DBMS_OUTPUT.PUT_LINE('[OUT_OF_STOCK] SQLCODE = ' || SQLCODE || ', SQLERRM=' || SQLERRM);
        
        else 
            DBMS_OUTPUT.PUT_LINE('[OTHERS] SQLCODE=' || SQLCODE || ', SQLERRM=' || SQLERRM);
        end if;

dbms_output.put_line('----- End BorrowBook -----');

end;
/