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
  id 48
  arrival_time 976.2143899206623
  lifetime 219.57230975030916
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 37
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 48
    gpu 31
    rom 7
  ]
  node [
    id 2
    label "2"
    cpu 25
    gpu 47
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 14
    gpu 8
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 5
    gpu 12
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 15
    gpu 41
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 25
  ]
  edge [
    source 2
    target 3
    bw 10
  ]
  edge [
    source 3
    target 4
    bw 12
  ]
  edge [
    source 4
    target 5
    bw 20
  ]
]
