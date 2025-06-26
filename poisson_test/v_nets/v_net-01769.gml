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
  id 1769
  arrival_time 39445.891951233636
  lifetime 213.40365721718513
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 20
    gpu 32
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 16
    gpu 37
    rom 23
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 13
    rom 26
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 39
    rom 36
  ]
  node [
    id 4
    label "4"
    cpu 17
    gpu 40
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 49
    gpu 47
    rom 22
  ]
  edge [
    source 0
    target 1
    bw 47
  ]
  edge [
    source 1
    target 2
    bw 41
  ]
  edge [
    source 2
    target 3
    bw 4
  ]
  edge [
    source 3
    target 4
    bw 26
  ]
  edge [
    source 4
    target 5
    bw 14
  ]
]
