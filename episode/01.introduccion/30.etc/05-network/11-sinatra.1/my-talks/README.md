# my-talks

**my-talk** as it means are... my talks.
It's a ruby tool that helps me to easily build presentation using
only... images and ERB files.

---

# How to use it?

1. Install *sinatra* gem (`gem install sinatra`)
1. Run presentation app doing `/talks/name/run.rb`.
1. Open your web browser and put URL http://localhost:4567

---

# Edittions

| Talk Name  | Language | Execute                    | State |
| ---------- | -------- | -------------------------- | ----- |
| 2014-tlp   | Spanish  | `./talks/2014-tlp/run.rb`   | OK    |
| 2016-chapi | Spanish  | `./talks/2016-chapi/run.rb` | DEV   |

---

# How do I create a new talk?

* `cp -r talks/skeleton talks/TALKNAME`, copy skeleton files into your new talk.
* Create your ERB files into `talks/TALKNAME/views`.
    * Call your ERB files using numbers as: `01-intro.erb`, `02-agenda.rb`.... We detect the page order using this convention.
* An ERB files is Ruby with emmebed HTML code.

---

# Where are our files?

```
.
├── lib
├── Rakefile
├── README.md
└── talks
    ├── 2014-tlp
    │   ├── map.rb
    │   ├── public
    │   │   ├── code
    │   │   └── images
    │   ├── run.rb
    │   └── views
    │       └── index.erb
    └── skeleton
        ├── map.rb
        ├── public
        │   ├── code
        │   └── images
        ├── run.rb
        └── views
            └── index.erb
```
