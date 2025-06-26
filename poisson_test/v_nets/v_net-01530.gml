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
  id 1530
  arrival_time 33840.14038296693
  lifetime 592.1578963529375
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 0
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 27
    rom 4
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 47
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 32
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 7
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 9
    gpu 4
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 10
    rom 18
  ]
  node [
    id 7
    label "7"
    cpu 10
    gpu 7
    rom 32
  ]
  node [
    id 8
    label "8"
    cpu 2
    gpu 42
    rom 38
  ]
  node [
    id 9
    label "9"
    cpu 4
    gpu 22
    rom 39
  ]
  node [
    id 10
    label "10"
    cpu 47
    gpu 17
    rom 22
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 9
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 33
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 42
  ]
  edge [
    source 5
    target 6
    bw 0
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 50
  ]
  edge [
    source 8
    target 9
    bw 11
  ]
  edge [
    source 9
    target 10
    bw 30
  ]
  edge [
    source 10
    target 11
    bw 4
  ]
]
