## Family Photo Project

In an effort to save the photos currently stored underneath my grandma's bed, I'm making a Rails application that uploads family photos alongside a family tree.

This is primarily to preserve photos, but I would like to include any other family history. I reckon some people might want to just to upload some stories (textual at first, then maybe audio recordings)

### Framework

All of my database relations.

#### Tables

* *Relative*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
first | string |
middle | string | can be nil
maiden | string | can be nil
surname | string |
nickname | string |  can be nil
sex | string | can this be an enum somewhere?
birthday | date |
deathday | date | can be nil

* *Photo*

has_one Location

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
taken_on | date |
header | string | can be nil
explanation | string | can be nil
location | id | reference to Location instance <br> can be nil

* *Memory*
has_one Relative

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
author | id | reference to Relative
content| text |

* *Location*

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
address | string | can be nil
city | string |
state | string | can be nil if country != USA
country | string |

* *Career*

has_one Relative
has_one Location

**Attribute** | **Value** | **Restrictions**
--- | --- | ---
id | integer | auto-generated
worker | id | reference to Relative
location | id | reference to Location
company | string | can be nil
start_date  | date | can be nil
end_date | date | can be nil

* *Education*

* *Event*

#### Joins

* *DescendantBranch*

* *CompanionBranch*

* *Tagged*


### Design
