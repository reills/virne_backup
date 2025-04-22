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
  id 982
  arrival_time 20946.779422371907
  lifetime 114.34137494867728
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 4
    gpu 36
    rom 27
  ]
  node [
    id 1
    label "1"
    cpu 47
    gpu 16
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 23
    gpu 41
    rom 24
  ]
  node [
    id 3
    label "3"
    cpu 10
    gpu 43
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 1
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 25
    gpu 35
    rom 7
  ]
  node [
    id 6
    label "6"
    cpu 7
    gpu 37
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 3
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 31
  ]
  edge [
    source 4
    target 5
    bw 36
  ]
  edge [
    source 5
    target 6
    bw 23
  ]
]
