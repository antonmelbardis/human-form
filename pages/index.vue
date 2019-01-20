<template>
  <section class="container">
    <div v-if="!readyForm">
      <div style="display: flex; align-items: center;margin-bottom:15px;">
        <div class="subtitle">
I am looking for a home for
</div>
        <div class="dropdown">
          <div v-if="!whatToCover" class="dropbtn-white" @click="myFunction" />
          <div v-else class="dropbtn" @click="myFunction">
            <div>{{ whatToCover }}</div>
          </div>
          <div id="myDropdown" class="dropdown-content">
            <ul class="faq__list">
              <li v-for="question in questions" :key="question.title" class="faq__item">
                <h3
                  class="faq__item-title"
                  @click="selectAnswer(question.title )"
                >
{{ question.title }}
</h3>
              </li>
            </ul>
          </div>
        </div>
      </div>
      <div v-if="isKids" style="display: flex; align-items: center; margin-bottom:15px;">
        <div class="subtitle" style="display: flex; align-items: center;">
          <div>{{ myOrOur }}</div>
          <div class="dropdown">
            <div v-if="!noOfKids" class="dropbtn-white" @click="openDropDownKids" />
            <div v-else class="dropbtn" @click="openDropDownKids">
              <div>{{ noOfKids }}</div>
            </div>

            <div id="noOfKids" class="dropdown-content">
              <ul class="faq__list">
                <li v-for="kid in noOfKidsOptions" :key="kid.no" class="faq__item">
                  <h3 class="faq__item-title" @click="selectNoOfKids(kid.no )">
{{ kid.no }}
</h3>
                </li>
              </ul>
            </div>
          </div>
          <span v-if="!noOfKids">
kid is
</span>
        </div>
        <div v-if="noOfKids" class="subtitle">
          <span>{{ noOfKids === '2' ? 'kids' : 'kid' }}</span>
          {{ noOfKids === '2' ? 'are' : 'is' }}
          <span v-if="!showOneOrTwoKids">
            <input v-model="kidOneAge" class="form-input">
          </span>
          <span v-if="showOneOrTwoKids">
            <input v-model="kidOneAge" class="form-input"> and
            <input v-model="kidTwoAge" class="form-input">
          </span> years old.
        </div>
      </div>
      <div
        v-if="!isKids && whatToCover || setKidsSectionReady"
        style="display: flex; align-items: center ; margin-bottom:25px;"
      >
        <div v-if="isSingle" class="subtitle">
          I earn
          <input v-model="myEarning" class="form-input">
        </div>

        <div v-else class="subtitle">
          I earn
          <input v-model="myEarning" class="form-input">
          <span v-if="!isSingle">
            and my partner earns
            <input v-model="partnerEarning" class="form-input">
          </span>
        </div>
      </div>
      <div
        v-if="showSubmittedButton"
        style="display: flex; align-items: center;margin: 0 auto; margin-top: 10px; margin-bottom:15px;"
      >
        <div class="button" @click="submit()">
          <div>SUBMIT</div>
        </div>
      </div>
    </div>

    <div v-if="readyForm">
      <div class="subtitle">
Thank you! 🙆‍ 👌
</div>
    </div>
  </section>
</template>

<script>
export default {
  components: {},
  data() {
    return {
      kidOneAge: '',
      kidTwoAge: '',
      // kidsSectionReady: F,
      myEarning: '',
      partnerEarning: '',
      whatToCover: '',
      noOfKids: '',
      questions: [
        {
          title: 'Just me'
        },
        {
          title: 'Me and my partner'
        },
        {
          title: 'Me, my Partner and my kids'
        },
        {
          title: 'Me and my Kids'
        }
      ],
      noOfKidsOptions: [{ no: '1' }, { no: '2' }],
      readyForm: ''
    }
  },
  computed: {
    showSubmittedButton() {
      if (this.isSingle && !this.isKids && this.myEarning) {
        return true
      } else if (
        !this.isSingle &&
        !this.isKids &&
        this.myEarning &&
        this.partnerEarning
      ) {
        return true
      } else if (
        !this.isSingle &&
        this.isKids &&
        this.setKidsSectionReady &&
        this.myEarning &&
        this.partnerEarning
      ) {
        return true
      } else if (
        this.isSingle &&
        this.isKids &&
        this.setKidsSectionReady &&
        this.myEarning
      ) {
        return true
      } else {
        return false
      }
    },
    setKidsSectionReady() {
      if (this.noOfKids === '2' && this.kidOneAge && this.kidTwoAge) {
        return true
      } else if (this.noOfKids === '1' && this.kidOneAge) {
        return true
      } else {
        return false
      }
    },
    // showWhatToCover() {
    //   if (this.postcode.length > 4) {
    //     return true
    //   } else {
    //     return false
    //   }
    // },
    isKids() {
      if (
        this.whatToCover === 'Me, my Partner and my kids' ||
        this.whatToCover === 'Me and my Kids'
      ) {
        return true
      } else {
        return false
      }
    },
    myOrOur() {
      if (this.whatToCover === 'Me and my Kids') {
        return 'My'
      } else {
        return 'Our'
      }
    },
    isSingle() {
      if (
        this.whatToCover === 'Just me' ||
        this.whatToCover === 'Me and my Kids'
      ) {
        return true
      } else {
        return false
      }
    },
    showOneOrTwoKids() {
      if (this.noOfKids === '2') {
        return true
      } else {
        return false
      }
    }
  },
  methods: {
    openDropDownKids() {
      document.getElementById('noOfKids').classList.toggle('show')
    },
    myFunction() {
      document.getElementById('myDropdown').classList.toggle('show')
    },
    selectAnswer(answer) {
      // console.log('fired')
      this.whatToCover = answer
      document.getElementById('myDropdown').classList.toggle('show', false)
    },
    selectNoOfKids(answer) {
      // console.log('fired')
      this.noOfKids = answer
      document.getElementById('noOfKids').classList.toggle('show', false)
    },
    submit() {
      this.readyForm = {
        is_single: this.isSingle,
        has_kids: this.isKids,
        earns: this.myEarning
      }

      setTimeout(function() {
        location.reload()
      }, 1000)
      // alert('Thank YOU!')
    }

    // Close the dropdown menu if the user clicks outside of it
  }
}
</script>

<style>
.dropbtn-white {
  height: 45px;
  width: 130px;
  /* background-color: white; */

  /* padding: 16px; */
  font-size: 42px;
  border: none;
  cursor: pointer;
  color: white;
}
.button {
  background-color: #35495e; /* Green */
  border: none;
  color: white;
  /* padding: 15px 32px; */
  text-align: center;
  text-decoration: none;
  display: inline-block;
  font-size: 16px;
}
.form-input {
  margin-left: 10px;
  width: 120px;
  height: 45px;
  font-size: 42px;
  font-weight: 300;
  color: #35495e;
  border: none;
  border-bottom: 5px solid grey;
}
.container {
  margin: 0 auto;
  min-height: 100vh;
  display: flex;
  justify-content: left;
  align-items: center;
  text-align: center;
}

.title {
  font-family: 'Quicksand', 'Source Sans Pro', -apple-system, BlinkMacSystemFont,
    'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif;
  display: block;
  font-weight: 300;
  font-size: 100px;
  color: #35495e;
  letter-spacing: 1px;
}

.subtitle {
  height: 45px;
  font-weight: 300;
  font-size: 42px;
  color: #526488;
  word-spacing: 5px;
  /* padding-bottom: 15px; */
  margin-bottom: 0px !important;
  border-bottom: 5px solid white;
}

.links {
  padding-top: 15px;
}
/* Dropdown Button */
.dropbtn {
  height: 50px;
  /* background-color: white; */

  color: #526488;
  /* padding: 16px; */
  font-size: 42px;
  border: none;
  cursor: pointer;
  /* padding-left: 5px;
  padding-bottom: 2px; */
  /* margin-left: 5px; */
}

/* The container <div> - needed to position the dropdown content */
.dropdown {
  height: 55px;
  position: relative;
  display: inline-block;
  border-bottom: 5px solid grey;
  margin-left: 10px;
  margin-right: 10px;
}

/* Dropdown Content (Hidden by Default) */
.dropdown-content {
  display: none;
  position: absolute;
  background-color: #f1f1f1;
  min-width: 160px;
  box-shadow: 0px 8px 16px 0px rgba(0, 0, 0, 0.2);
  z-index: 1;
}

/* Links inside the dropdown */
.dropdown-content a {
  color: black;
  padding: 12px 16px;
  text-decoration: none;
  display: block;
}

/* Change color of dropdown links on hover */
.dropdown-content a:hover {
  background-color: #ddd;
}

/* Show the dropdown menu (use JS to add this class to the .dropdown-content container when the user clicks on the dropdown button) */
.show {
  display: block;
}
</style>
