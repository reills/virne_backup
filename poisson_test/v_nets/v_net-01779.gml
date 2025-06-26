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
  id 1779
  arrival_time 39576.71083983513
  lifetime 785.4253014551458
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 44
    gpu 21
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 14
    gpu 34
    rom 13
  ]
  node [
    id 2
    label "2"
    cpu 0
    gpu 43
    rom 36
  ]
  node [
    id 3
    label "3"
    cpu 30
    gpu 37
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 14
    rom 39
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 43
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 35
    gpu 32
    rom 49
  ]
  edge [
    source 0
    target 1
    bw 24
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 25
  ]
  edge [
    source 4
    target 5
    bw 18
  ]
  edge [
    source 5
    target 6
    bw 26
  ]
]
