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
  id 717
  arrival_time 15021.245259002375
  lifetime 1972.1934163193557
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 49
    rom 18
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 29
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 5
    rom 19
  ]
  node [
    id 3
    label "3"
    cpu 32
    gpu 26
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 36
    gpu 31
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 46
    gpu 6
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 5
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 50
    gpu 10
    rom 15
  ]
  node [
    id 8
    label "8"
    cpu 0
    gpu 33
    rom 8
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 17
    rom 30
  ]
  node [
    id 10
    label "10"
    cpu 4
    gpu 17
    rom 13
  ]
  node [
    id 11
    label "11"
    cpu 7
    gpu 30
    rom 31
  ]
  edge [
    source 0
    target 1
    bw 49
  ]
  edge [
    source 1
    target 2
    bw 12
  ]
  edge [
    source 2
    target 3
    bw 25
  ]
  edge [
    source 3
    target 4
    bw 49
  ]
  edge [
    source 4
    target 5
    bw 48
  ]
  edge [
    source 5
    target 6
    bw 31
  ]
  edge [
    source 6
    target 7
    bw 39
  ]
  edge [
    source 7
    target 8
    bw 45
  ]
  edge [
    source 8
    target 9
    bw 29
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 2
  ]
]
