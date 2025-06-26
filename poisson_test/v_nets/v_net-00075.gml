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
  id 75
  arrival_time 1562.3825659576928
  lifetime 191.9413488722939
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 10
    gpu 13
    rom 44
  ]
  node [
    id 1
    label "1"
    cpu 20
    gpu 39
    rom 33
  ]
  node [
    id 2
    label "2"
    cpu 12
    gpu 43
    rom 1
  ]
  node [
    id 3
    label "3"
    cpu 47
    gpu 15
    rom 41
  ]
  node [
    id 4
    label "4"
    cpu 43
    gpu 16
    rom 23
  ]
  node [
    id 5
    label "5"
    cpu 44
    gpu 30
    rom 14
  ]
  node [
    id 6
    label "6"
    cpu 34
    gpu 22
    rom 3
  ]
  edge [
    source 0
    target 1
    bw 45
  ]
  edge [
    source 1
    target 2
    bw 17
  ]
  edge [
    source 2
    target 3
    bw 2
  ]
  edge [
    source 3
    target 4
    bw 37
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 33
  ]
]
