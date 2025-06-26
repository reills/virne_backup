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
  id 1868
  arrival_time 40964.239305307216
  lifetime 691.9049603857111
  num_nodes 8
  type "path"
  node [
    id 0
    label "0"
    cpu 19
    gpu 0
    rom 11
  ]
  node [
    id 1
    label "1"
    cpu 5
    gpu 44
    rom 40
  ]
  node [
    id 2
    label "2"
    cpu 35
    gpu 6
    rom 30
  ]
  node [
    id 3
    label "3"
    cpu 7
    gpu 30
    rom 48
  ]
  node [
    id 4
    label "4"
    cpu 19
    gpu 26
    rom 3
  ]
  node [
    id 5
    label "5"
    cpu 34
    gpu 19
    rom 24
  ]
  node [
    id 6
    label "6"
    cpu 19
    gpu 34
    rom 37
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 4
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 5
  ]
  edge [
    source 1
    target 2
    bw 6
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 27
  ]
  edge [
    source 4
    target 5
    bw 27
  ]
  edge [
    source 5
    target 6
    bw 22
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
]
