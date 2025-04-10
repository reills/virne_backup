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
  id 1392
  arrival_time 29340.97165648939
  lifetime 2386.435506411615
  num_nodes 4
  type "path"
  node [
    id 0
    label "0"
    cpu 25
    gpu 22
    rom 23
  ]
  node [
    id 1
    label "1"
    cpu 40
    gpu 32
    rom 22
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 21
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 16
    gpu 5
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 28
  ]
  edge [
    source 2
    target 3
    bw 47
  ]
]
