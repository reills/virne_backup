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
  id 1121
  arrival_time 23335.38997998063
  lifetime 3493.969510363763
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 18
    gpu 29
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 22
    gpu 20
    rom 48
  ]
  node [
    id 2
    label "2"
    cpu 30
    gpu 23
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 8
    rom 33
  ]
  node [
    id 4
    label "4"
    cpu 14
    gpu 3
    rom 13
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 37
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 48
    rom 47
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 21
    rom 45
  ]
  node [
    id 8
    label "8"
    cpu 46
    gpu 5
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 30
  ]
  edge [
    source 1
    target 2
    bw 7
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 12
  ]
  edge [
    source 5
    target 6
    bw 41
  ]
  edge [
    source 6
    target 7
    bw 17
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
]
