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
  id 1555
  arrival_time 34284.1375064975
  lifetime 593.2225611882103
  num_nodes 6
  type "path"
  node [
    id 0
    label "0"
    cpu 8
    gpu 10
    rom 10
  ]
  node [
    id 1
    label "1"
    cpu 10
    gpu 43
    rom 14
  ]
  node [
    id 2
    label "2"
    cpu 48
    gpu 20
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 49
    gpu 42
    rom 44
  ]
  node [
    id 4
    label "4"
    cpu 13
    gpu 23
    rom 18
  ]
  node [
    id 5
    label "5"
    cpu 43
    gpu 32
    rom 41
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 19
  ]
  edge [
    source 2
    target 3
    bw 0
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 40
  ]
]
