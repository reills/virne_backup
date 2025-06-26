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
  id 1814
  arrival_time 40208.023223600896
  lifetime 2473.4482714503965
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 41
    gpu 26
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 6
    gpu 9
    rom 25
  ]
  node [
    id 2
    label "2"
    cpu 39
    gpu 18
    rom 20
  ]
  node [
    id 3
    label "3"
    cpu 20
    gpu 8
    rom 46
  ]
  node [
    id 4
    label "4"
    cpu 26
    gpu 9
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 49
    rom 5
  ]
  node [
    id 6
    label "6"
    cpu 33
    gpu 8
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 5
    gpu 20
    rom 42
  ]
  node [
    id 8
    label "8"
    cpu 47
    gpu 46
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 26
  ]
  edge [
    source 1
    target 2
    bw 36
  ]
  edge [
    source 2
    target 3
    bw 34
  ]
  edge [
    source 3
    target 4
    bw 15
  ]
  edge [
    source 4
    target 5
    bw 49
  ]
  edge [
    source 5
    target 6
    bw 46
  ]
  edge [
    source 6
    target 7
    bw 1
  ]
  edge [
    source 7
    target 8
    bw 36
  ]
]
