#Lease Manager Readme

Schema Spec:
1. Functionality can either be exposed through a RESTful JSON API or simple web pages.
2. Users must have a first name, last name, email, and password.
3. A User can either be an Owner, Manager, or Tenant.
4. An Owner can create a Lease.
5. A Lease must have an address, monthly rent amount, start date, end date, and rent payment day (e.g. the 1st of every month).
6. An Owner can add Managers and Tenants to a Lease.
7. Owners, Managers, and Tenants can view their Leases.
8. Owners and Managers can update a Lease’s data.
9. A Tenant can accept a Lease that they have been added to.

Behavior Spec:
1. When all Tenants have accepted a Lease, the Lease becomes “binding” and is no longer editable.
2. Users can view a list of their contacts (all other users connected to that user through a lease).
3. Every month, on the rent payment day for each binding lease, Tenants receive an email reminding them that rent is due.
4. Two months before the end date for each binding lease, the Owners and Managers receive an email reminding them that the lease is ending soon.
5. Owners and Managers can view a financial dashboard by calendar year:
    • For each month in that calendar year, they see a summary of the rent collected or to be collected in that month, and they can filter by lease or see a total across all leases.
6. Rent proration: for any lease that starts and/or ends in the middle of a month, the rent amount should be prorated based on the number of days in that month. 