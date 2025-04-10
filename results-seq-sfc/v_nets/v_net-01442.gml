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
  id 1442
  arrival_time 30248.106218151468
  lifetime 195.53416213401601
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 17
    gpu 11
    rom 9
  ]
  node [
    id 1
    label "1"
    cpu 35
    gpu 35
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 18
    gpu 16
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 13
    rom 20
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 20
    rom 35
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 9
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 33
    rom 10
  ]
  node [
    id 7
    label "7"
    cpu 18
    gpu 39
    rom 5
  ]
  node [
    id 8
    label "8"
    cpu 32
    gpu 47
    rom 22
  ]
  node [
    id 9
    label "9"
    cpu 13
    gpu 43
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 6
  ]
  edge [
    source 1
    target 2
    bw 32
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 44
  ]
  edge [
    source 4
    target 5
    bw 30
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 12
  ]
  edge [
    source 7
    target 8
    bw 20
  ]
  edge [
    source 8
    target 9
    bw 9
  ]
]
