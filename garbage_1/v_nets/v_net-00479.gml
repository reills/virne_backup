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
  id 479
  arrival_time 8900.061367458637
  lifetime 952.1994641821968
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 5
    gpu 5
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 44
    gpu 28
    rom 11
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 13
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 27
    rom 21
  ]
  node [
    id 4
    label "4"
    cpu 7
    gpu 2
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 45
    gpu 18
    rom 17
  ]
  node [
    id 6
    label "6"
    cpu 30
    gpu 14
    rom 33
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 41
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 32
    rom 35
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 36
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
  edge [
    source 6
    target 7
    bw 7
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
]
