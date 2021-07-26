namespace :national_curriculum_statements do
  desc 'add national curriculum statements to database'
  task populate: :environment do


  end

  def statements
    [
      { number: '1.1',
        statement: 'Understand what algorithms are; how they are implemented as programs on digital devices; and that programs execute by following precise and unambiguous instructions' },
      { number: '1.2', statement: 'Create and debug simple programs' },
      { number: '1.3', statement: 'Use logical reasoning to predict the behaviour of simple programs' },
      { number: '1.4',
        statement: 'Use technology purposefully to create, organise, store, manipulate and retrieve digital content' },
      { number: '1.5', statement: 'Recognise common uses of information technology beyond school' },
      { number: '1.6',
        statement: 'Use technology safely and respectfully, keeping personal information private; identify where to go for help and support when they have concerns about content or contact on the internet or other online technologies.' },
      { number: '2.1',
        statement: 'Design, write and debug programs that accomplish specific goals, including controlling or simulating physical systems; solve problems by decomposing them into smaller parts' },
      { number: '2.2',
        statement: 'Use sequence, selection, and repetition in programs; work with variables and various forms of input and output' },
      { number: '2.3',
        statement: 'Use logical reasoning to explain how some simple algorithms work and to detect and correct errors in algorithms and programs' },
      { number: '2.4',
        statement: 'Understand computer networks including the internet; how they can provide multiple services, such as the world wide web; and the opportunities they offer for communication and collaboration' },
      { number: '2.5',
        statement: 'Use search technologies effectively, appreciate how results are selected and ranked, and be discerning in evaluating digital content' },
      { number: '2.6',
        statement: 'Select, use and combine a variety of software (including internet services) on a range of digital devices to design and create a range of programs, systems and content that accomplish given goals, including collecting, analysing, evaluating and presenting data and information' },
      { number: '2.7',
        statement: 'Use technology safely, respectfully and responsibly; recognise acceptable/unacceptable behaviour; identify a range of ways to report concerns about content and contact.' },
      { number: '3.1',
        statement: 'Design, use and evaluate computational abstractions that model the state and behaviour of real-world problems and physical systems' },
      { number: '3.2',
        statement: 'Understand several key algorithms that reflect computational thinking [for example, ones for sorting and searching]; use logical reasoning to compare the utility of alternative algorithms for the same problem' },
      { number: '3.3',
        statement: 'Use two or more programming languages, at least one of which is textual, to solve a variety of computational problems; make appropriate use of data structures [for example, lists, tables or arrays]; design and develop modular programs that use procedures or functions' },
      { number: '3.4',
        statement: 'Understand simple Boolean logic [for example, AND, OR and NOT] and some of its uses in circuits and programming; understand how numbers can be represented in binary, and be able to carry out simple operations on binary numbers [for example, binary addition, and conversion between binary and decimal]' },
      { number: '3.5',
        statement: 'Understand the hardware and software components that make up computer systems, and how they communicate with one another and with other systems' },
      { number: '3.6',
        statement: 'Understand how instructions are stored and executed within a computer system; understand how data of various types (including text, sounds and pictures) can be represented and manipulated digitally, in the form of binary digits' },
      { number: '3.7',
        statement: 'Undertake creative projects that involve selecting, using, and combining multiple applications, preferably across a range of devices, to achieve challenging goals, including collecting and analysing data and meeting the needs of known users' },
      { number: '3.8',
        statement: 'Create, re-use, revise and re-purpose digital artefacts for a given audience, with attention to trustworthiness, design and usability' },
      { number: '3.9',
        statement: 'Understand a range of ways to use technology safely, respectfully, responsibly and securely, including protecting their online identity and privacy; recognise inappropriate content, contact and conduct and know how to report concerns.' },
      { number: '4.1',
        statement: 'Develop their capability, creativity and knowledge in computer science, digital media andinformation technology' },
      { number: '4.2',
        statement: 'Develop and apply their analytic, problem-solving, design, and computational thinking skils' },
      { number: '4.3',
        statement: 'Understand how changes in technology affect safety, including new ways to protect their online privacy and identity, and how to identify and report a range of concerns.' }
    ]
  end
end
