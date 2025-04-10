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
  id 797
  arrival_time 16630.73481756773
  lifetime 1963.4091362537029
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 49
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 28
    rom 26
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 41
    rom 40
  ]
  node [
    id 3
    label "3"
    cpu 22
    gpu 17
    rom 43
  ]
  node [
    id 4
    label "4"
    cpu 41
    gpu 32
    rom 11
  ]
  node [
    id 5
    label "5"
    cpu 2
    gpu 31
    rom 48
  ]
  edge [
    source 0
    target 1
    bw 40
  ]
  edge [
    source 1
    target 2
    bw 37
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 16
  ]
  edge [
    source 4
    target 5
    bw 4
  ]
]
