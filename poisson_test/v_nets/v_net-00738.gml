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
  id 738
  arrival_time 15489.438876032038
  lifetime 68.32619864905313
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 40
    rom 3
  ]
  node [
    id 1
    label "1"
    cpu 32
    gpu 17
    rom 15
  ]
  node [
    id 2
    label "2"
    cpu 31
    gpu 46
    rom 44
  ]
  node [
    id 3
    label "3"
    cpu 11
    gpu 49
    rom 15
  ]
  node [
    id 4
    label "4"
    cpu 23
    gpu 46
    rom 42
  ]
  node [
    id 5
    label "5"
    cpu 11
    gpu 22
    rom 1
  ]
  node [
    id 6
    label "6"
    cpu 49
    gpu 24
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 8
    gpu 7
    rom 49
  ]
  node [
    id 8
    label "8"
    cpu 49
    gpu 10
    rom 46
  ]
  node [
    id 9
    label "9"
    cpu 7
    gpu 31
    rom 28
  ]
  edge [
    source 0
    target 1
    bw 7
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 21
  ]
  edge [
    source 4
    target 5
    bw 22
  ]
  edge [
    source 5
    target 6
    bw 7
  ]
  edge [
    source 6
    target 7
    bw 27
  ]
  edge [
    source 7
    target 8
    bw 47
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
]
