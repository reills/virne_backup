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
  id 1022
  arrival_time 21691.692724344975
  lifetime 1957.6218351971045
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 36
    gpu 15
    rom 26
  ]
  node [
    id 1
    label "1"
    cpu 13
    gpu 37
    rom 17
  ]
  node [
    id 2
    label "2"
    cpu 13
    gpu 1
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 23
    gpu 32
    rom 40
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 33
    rom 12
  ]
  node [
    id 5
    label "5"
    cpu 14
    gpu 46
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 40
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 14
    gpu 11
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 37
    gpu 23
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 6
    gpu 33
    rom 2
  ]
  node [
    id 10
    label "10"
    cpu 42
    gpu 47
    rom 47
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 15
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 13
  ]
  edge [
    source 5
    target 6
    bw 50
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
  edge [
    source 8
    target 9
    bw 37
  ]
  edge [
    source 9
    target 10
    bw 37
  ]
]
