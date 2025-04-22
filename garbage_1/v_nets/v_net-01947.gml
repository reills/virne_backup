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
  id 1947
  arrival_time 42796.39427778029
  lifetime 952.7612873072226
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 32
    gpu 5
    rom 24
  ]
  node [
    id 1
    label "1"
    cpu 28
    gpu 30
    rom 31
  ]
  node [
    id 2
    label "2"
    cpu 22
    gpu 37
    rom 13
  ]
  node [
    id 3
    label "3"
    cpu 15
    gpu 27
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 29
    gpu 16
    rom 24
  ]
  node [
    id 5
    label "5"
    cpu 7
    gpu 34
    rom 44
  ]
  node [
    id 6
    label "6"
    cpu 6
    gpu 10
    rom 1
  ]
  node [
    id 7
    label "7"
    cpu 13
    gpu 19
    rom 34
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 11
    rom 4
  ]
  node [
    id 9
    label "9"
    cpu 11
    gpu 26
    rom 6
  ]
  node [
    id 10
    label "10"
    cpu 22
    gpu 19
    rom 17
  ]
  node [
    id 11
    label "11"
    cpu 5
    gpu 8
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 40
  ]
  edge [
    source 3
    target 4
    bw 50
  ]
  edge [
    source 4
    target 5
    bw 0
  ]
  edge [
    source 5
    target 6
    bw 25
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 16
  ]
  edge [
    source 9
    target 10
    bw 34
  ]
  edge [
    source 10
    target 11
    bw 11
  ]
]
