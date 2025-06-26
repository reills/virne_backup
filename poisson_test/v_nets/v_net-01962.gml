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
  id 1962
  arrival_time 42951.30178745439
  lifetime 815.6862328147924
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 13
    gpu 41
    rom 12
  ]
  node [
    id 1
    label "1"
    cpu 29
    gpu 35
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 47
    gpu 33
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 2
    gpu 50
    rom 45
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 46
    rom 38
  ]
  node [
    id 5
    label "5"
    cpu 12
    gpu 18
    rom 19
  ]
  node [
    id 6
    label "6"
    cpu 9
    gpu 39
    rom 1
  ]
  edge [
    source 0
    target 1
    bw 15
  ]
  edge [
    source 1
    target 2
    bw 22
  ]
  edge [
    source 2
    target 3
    bw 7
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 44
  ]
]
