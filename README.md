# Vending Partnerships through Keys

This repository holds a set of PHP classes designed to support public
sign up of Partners. Those Partners are allowed to extend Models which
are XML documents with assets at identified substitution points. When
Partners extend Models they may specify values or upload files as
assets to be to be built into the Models. Setting the permanent assets
and optionally identifying defaults for Customer assets allows the
Model to create a new Products for that Partner.

### Code organization

This prototype offers the object structure under angle/class. A crude
Model building and test interface via web forms at
angel/loadup/web. The directory at angle/partner is a WordPress site
demo-ing Partner access working with Models and Products. The actual
work in the WordPress demo pages is contained in
angel/partner/wp-content/themes/the-bootstrap/templates within the two
files: orders.php and partnerKeys.php.

### Object hierarchy objectives

Each substitution in a Model may be locked by the Partner or
identified as extendable by the Customer when that Product Order is
created. The system provides a vendor price for Models and allows the
Partner to set the retail price of each Product.

Orders include shipping Label information and allow the Customer to
identify and reuse multiple Destinations. Order processing
accommodates multiple Items, external transaction clearing and
culminates with XML Order submission to the "factory".

A recording http endpoint tracks progress by Item by accepting status
messages accompanied by Item keys.

All of the nouns capitalized above are represented as PHP
objects. The creation of each produces a unique, type identified, Key
which may be used to access the object in the mySql database.

### Object construction and instantiation

The objects are built on a tally-factory model. Rather than
maintaining a separate factory object constructors and tally methods
record or directly instantiate objects to/from the database. Tally
methods take advantage of multi-typed properties to instantiate lists
of objects matching criteria expressed in the properties of a
prototype object. (E.G "<1/1/2009" for dates befor 2009)

In this work constructors take Keys to instantiate specific objects or
they can tally all of the descendant objects when handed a parent. For
example given a Partner Key a tree can be produced containing: a
filtered list of Customers, continuing to a filtered list of Orders
perhaps with specific Items. The technique used accomplishes building
these object trees in memory after a single database trip.

### Database discipline 

For convenience of access and to address concerns of database
independence an object wrapper for the mysqli PHP object interface is
presented. Along with list construction and parameter cleaning methods
the class DboMy returns a consolidated Result object. The pair also
handles exception messaging, SQL statement debug tracking and
microsecond based timing functionality.
