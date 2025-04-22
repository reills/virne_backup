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
  id 461
  arrival_time 8699.509470900028
  lifetime 746.5682068904309
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 39
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 30
    gpu 10
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 17
    gpu 1
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 25
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 35
    gpu 13
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 4
    rom 11
  ]
  node [
    id 6
    label "6"
    cpu 21
    gpu 39
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 37
    gpu 27
    rom 47
  ]
  node [
    id 8
    label "8"
    cpu 11
    gpu 46
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 17
    rom 42
  ]
  node [
    id 10
    label "10"
    cpu 5
    gpu 49
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 21
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 17
  ]
  edge [
    source 9
    target 10
    bw 37
  ]
]
