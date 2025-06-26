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
  id 986
  arrival_time 20997.571347161385
  lifetime 2418.531456713609
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 43
    rom 43
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 49
    rom 43
  ]
  node [
    id 2
    label "2"
    cpu 15
    gpu 33
    rom 41
  ]
  node [
    id 3
    label "3"
    cpu 48
    gpu 21
    rom 25
  ]
  node [
    id 4
    label "4"
    cpu 37
    gpu 29
    rom 28
  ]
  node [
    id 5
    label "5"
    cpu 8
    gpu 2
    rom 25
  ]
  node [
    id 6
    label "6"
    cpu 47
    gpu 22
    rom 30
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 17
    rom 23
  ]
  node [
    id 8
    label "8"
    cpu 43
    gpu 42
    rom 33
  ]
  edge [
    source 0
    target 1
    bw 21
  ]
  edge [
    source 1
    target 2
    bw 3
  ]
  edge [
    source 2
    target 3
    bw 42
  ]
  edge [
    source 3
    target 4
    bw 42
  ]
  edge [
    source 4
    target 5
    bw 39
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 14
  ]
  edge [
    source 7
    target 8
    bw 39
  ]
]
