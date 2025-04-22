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
  id 705
  arrival_time 14821.216083872278
  lifetime 792.9736399180528
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 16
    gpu 33
    rom 1
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 27
    rom 0
  ]
  node [
    id 2
    label "2"
    cpu 24
    gpu 12
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 39
    gpu 40
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 6
    gpu 15
    rom 21
  ]
  node [
    id 5
    label "5"
    cpu 6
    gpu 9
    rom 21
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 18
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 19
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 33
    gpu 27
    rom 4
  ]
  edge [
    source 0
    target 1
    bw 44
  ]
  edge [
    source 1
    target 2
    bw 13
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 9
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 22
  ]
]
