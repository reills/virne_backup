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
  id 1438
  arrival_time 30216.69702160585
  lifetime 406.34785836981
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 37
    rom 4
  ]
  node [
    id 1
    label "1"
    cpu 49
    gpu 46
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 1
    gpu 34
    rom 28
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 37
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 34
    gpu 42
    rom 10
  ]
  node [
    id 5
    label "5"
    cpu 41
    gpu 28
    rom 0
  ]
  edge [
    source 0
    target 1
    bw 43
  ]
  edge [
    source 1
    target 2
    bw 14
  ]
  edge [
    source 2
    target 3
    bw 38
  ]
  edge [
    source 3
    target 4
    bw 24
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
]
