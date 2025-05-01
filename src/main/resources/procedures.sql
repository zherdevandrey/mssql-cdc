EXEC sp_configure 'clr enabled', 1; RECONFIGURE;
EXEC sp_configure 'clr strict security', 0; RECONFIGURE;
EXEC sp_configure 'clr enabled';

CREATE ASSEMBLY LaunchDispatchWrapper
    FROM 'LaunchDispatchWrapper.dll'
    WITH PERMISSION_SET = SAFE; -- Или UNSAFE/EXTERNAL_ACCESS при необходимости


CREATE PROCEDURE LaunchDispatchWrapper
@id INT
AS EXTERNAL NAME LaunchDispatchWrapper.[LaunchDispatchWrapper].launchDispatch;

EXEC LaunchDispatchWrapper @ID = 1;

---

create table C2C_TRANSFER
(
    ID     int identity (0, 1),
    STATUS int,
    AMOUNT int
)
go


CREATE PROCEDURE ISMPL2_C2C_TRANSFER
    @Amount INT,
    @NewId INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    INSERT INTO C2C_TRANSFER (AMOUNT)
    VALUES (@Amount);

    -- Получение ID последней вставленной строки
    SET @NewId = SCOPE_IDENTITY();
END;


CREATE PROCEDURE EXECUTE_DISPATCH
@ID INT
AS
    BEGIN
        -- Пауза на 5 секунд
        WAITFOR DELAY '00:00:05';

        -- Обновление статуса для конкретного ID
        UPDATE C2C_TRANSFER
        SET STATUS = 2
        WHERE ID = @ID;
    END;