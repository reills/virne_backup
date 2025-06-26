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
  id 759
  arrival_time 16013.425760268494
  lifetime 844.0892685218098
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 45
    gpu 16
    rom 14
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 38
    rom 20
  ]
  node [
    id 2
    label "2"
    cpu 3
    gpu 11
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 10
    rom 2
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 16
    rom 16
  ]
  node [
    id 5
    label "5"
    cpu 16
    gpu 21
    rom 38
  ]
  node [
    id 6
    label "6"
    cpu 5
    gpu 22
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 12
    gpu 29
    rom 8
  ]
  node [
    id 8
    label "8"
    cpu 40
    gpu 45
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 25
    gpu 47
    rom 46
  ]
  node [
    id 10
    label "10"
    cpu 49
    gpu 4
    rom 44
  ]
  node [
    id 11
    label "11"
    cpu 35
    gpu 32
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 18
  ]
  edge [
    source 2
    target 3
    bw 48
  ]
  edge [
    source 3
    target 4
    bw 8
  ]
  edge [
    source 4
    target 5
    bw 16
  ]
  edge [
    source 5
    target 6
    bw 5
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 13
  ]
  edge [
    source 9
    target 10
    bw 5
  ]
  edge [
    source 10
    target 11
    bw 3
  ]
]
