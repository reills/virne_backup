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
  id 1173
  arrival_time 24344.09126854856
  lifetime 606.8745061961754
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 2
    rom 50
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 45
    rom 6
  ]
  node [
    id 2
    label "2"
    cpu 26
    gpu 33
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 43
    rom 49
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 3
    rom 34
  ]
  node [
    id 5
    label "5"
    cpu 35
    gpu 3
    rom 16
  ]
  node [
    id 6
    label "6"
    cpu 16
    gpu 15
    rom 26
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 24
  ]
  edge [
    source 3
    target 4
    bw 45
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 32
  ]
]
