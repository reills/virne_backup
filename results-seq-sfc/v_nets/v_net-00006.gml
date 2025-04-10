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
  id 6
  arrival_time 126.17011937131875
  lifetime 47.21826584507378
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 42
    gpu 46
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 37
    gpu 46
    rom 24
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 9
    rom 15
  ]
  node [
    id 3
    label "3"
    cpu 8
    gpu 49
    rom 47
  ]
  node [
    id 4
    label "4"
    cpu 46
    gpu 12
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 24
    gpu 3
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 40
    gpu 29
    rom 3
  ]
  node [
    id 7
    label "7"
    cpu 44
    gpu 30
    rom 14
  ]
  node [
    id 8
    label "8"
    cpu 23
    gpu 38
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 8
  ]
  edge [
    source 3
    target 4
    bw 48
  ]
  edge [
    source 4
    target 5
    bw 24
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 32
  ]
  edge [
    source 7
    target 8
    bw 17
  ]
]
