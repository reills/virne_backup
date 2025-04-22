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
  id 325
  arrival_time 6151.499025437274
  lifetime 749.399284776964
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 50
    rom 8
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 32
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 14
    gpu 2
    rom 48
  ]
  node [
    id 3
    label "3"
    cpu 37
    gpu 3
    rom 18
  ]
  node [
    id 4
    label "4"
    cpu 25
    gpu 42
    rom 40
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 11
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 26
    gpu 15
    rom 29
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 49
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 10
    gpu 22
    rom 3
  ]
  node [
    id 9
    label "9"
    cpu 38
    gpu 44
    rom 36
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 11
  ]
  edge [
    source 2
    target 3
    bw 6
  ]
  edge [
    source 3
    target 4
    bw 20
  ]
  edge [
    source 4
    target 5
    bw 28
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 48
  ]
  edge [
    source 7
    target 8
    bw 10
  ]
  edge [
    source 8
    target 9
    bw 31
  ]
]
