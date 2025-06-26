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
  id 1669
  arrival_time 37206.37603075388
  lifetime 6.576628013768754
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 36
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 1
    gpu 12
    rom 36
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 31
    rom 25
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 15
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 0
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 29
    rom 37
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 0
    rom 49
  ]
  node [
    id 7
    label "7"
    cpu 25
    gpu 11
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 21
    gpu 27
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 17
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 20
  ]
  edge [
    source 3
    target 4
    bw 5
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
]
