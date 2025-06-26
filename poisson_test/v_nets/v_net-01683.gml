graph [
  node_attrs_setting [
    name "cpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "gpu"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  node_attrs_setting [
    name "rom"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "node"
    type "resource"
  ]
  link_attrs_setting "_networkx_list_start"
  link_attrs_setting [
    name "bw"
    distribution "uniform"
    dtype "int"
    generative 1
    low 0
    high 50
    owner "link"
    type "resource"
  ]
  id 1683
  arrival_time 37501.26342276788
  lifetime 1035.0156635589756
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 0
    gpu 18
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 36
    gpu 19
    rom 38
  ]
  node [
    id 2
    label "2"
    cpu 45
    gpu 18
    rom 23
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 12
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 38
    rom 15
  ]
  node [
    id 5
    label "5"
    cpu 39
    gpu 23
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 27
    gpu 15
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 28
    gpu 48
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 48
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 18
    gpu 17
    rom 5
  ]
  node [
    id 10
    label "10"
    cpu 26
    gpu 37
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 9
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 40
  ]
  edge [
    source 4
    target 5
    bw 11
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 27
  ]
]
