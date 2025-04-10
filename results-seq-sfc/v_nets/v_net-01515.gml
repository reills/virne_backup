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
  id 1515
  arrival_time 33670.718317457664
  lifetime 1617.6396877962886
  num_nodes 14
  type "path"
  node [
    id 0
    label "0"
    cpu 26
    gpu 6
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 35
    rom 45
  ]
  node [
    id 2
    label "2"
    cpu 42
    gpu 43
    rom 45
  ]
  node [
    id 3
    label "3"
    cpu 35
    gpu 0
    rom 23
  ]
  node [
    id 4
    label "4"
    cpu 3
    gpu 32
    rom 9
  ]
  node [
    id 5
    label "5"
    cpu 40
    gpu 8
    rom 22
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 6
    rom 22
  ]
  node [
    id 7
    label "7"
    cpu 21
    gpu 37
    rom 27
  ]
  node [
    id 8
    label "8"
    cpu 27
    gpu 12
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 16
    gpu 17
    rom 4
  ]
  node [
    id 10
    label "10"
    cpu 1
    gpu 0
    rom 30
  ]
  node [
    id 11
    label "11"
    cpu 3
    gpu 13
    rom 14
  ]
  node [
    id 12
    label "12"
    cpu 6
    gpu 25
    rom 5
  ]
  node [
    id 13
    label "13"
    cpu 15
    gpu 1
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 0
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 16
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 17
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 41
  ]
  edge [
    source 8
    target 9
    bw 5
  ]
  edge [
    source 9
    target 10
    bw 46
  ]
  edge [
    source 10
    target 11
    bw 27
  ]
  edge [
    source 11
    target 12
    bw 42
  ]
  edge [
    source 12
    target 13
    bw 13
  ]
]
