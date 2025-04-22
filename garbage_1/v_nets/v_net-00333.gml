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
  id 333
  arrival_time 6342.886895568171
  lifetime 254.87721434352605
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 50
    rom 6
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 16
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 11
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 13
    gpu 40
    rom 7
  ]
  node [
    id 4
    label "4"
    cpu 20
    gpu 27
    rom 1
  ]
  node [
    id 5
    label "5"
    cpu 38
    gpu 3
    rom 6
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 34
  ]
]
