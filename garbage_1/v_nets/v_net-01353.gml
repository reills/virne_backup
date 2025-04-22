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
  id 1353
  arrival_time 28616.056927234033
  lifetime 1102.8278343135096
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 29
    gpu 40
    rom 46
  ]
  node [
    id 1
    label "1"
    cpu 27
    gpu 42
    rom 1
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 31
    rom 21
  ]
  node [
    id 3
    label "3"
    cpu 3
    gpu 11
    rom 13
  ]
  node [
    id 4
    label "4"
    cpu 10
    gpu 27
    rom 4
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 44
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 50
    gpu 11
    rom 6
  ]
  node [
    id 7
    label "7"
    cpu 24
    gpu 23
    rom 10
  ]
  node [
    id 8
    label "8"
    cpu 30
    gpu 35
    rom 10
  ]
  node [
    id 9
    label "9"
    cpu 40
    gpu 49
    rom 35
  ]
  node [
    id 10
    label "10"
    cpu 15
    gpu 17
    rom 50
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 0
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 23
  ]
  edge [
    source 4
    target 5
    bw 47
  ]
  edge [
    source 5
    target 6
    bw 19
  ]
  edge [
    source 6
    target 7
    bw 2
  ]
  edge [
    source 7
    target 8
    bw 27
  ]
  edge [
    source 8
    target 9
    bw 0
  ]
  edge [
    source 9
    target 10
    bw 2
  ]
]
