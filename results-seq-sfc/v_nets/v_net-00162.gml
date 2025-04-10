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
  id 162
  arrival_time 3086.152274931635
  lifetime 36.84641738049906
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 9
    gpu 37
    rom 42
  ]
  node [
    id 1
    label "1"
    cpu 4
    gpu 15
    rom 19
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 13
    rom 32
  ]
  node [
    id 3
    label "3"
    cpu 27
    gpu 8
    rom 0
  ]
  node [
    id 4
    label "4"
    cpu 8
    gpu 26
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 42
    gpu 3
    rom 18
  ]
  node [
    id 6
    label "6"
    cpu 24
    gpu 4
    rom 5
  ]
  node [
    id 7
    label "7"
    cpu 47
    gpu 21
    rom 48
  ]
  node [
    id 8
    label "8"
    cpu 41
    gpu 22
    rom 37
  ]
  node [
    id 9
    label "9"
    cpu 9
    gpu 3
    rom 23
  ]
  node [
    id 10
    label "10"
    cpu 36
    gpu 6
    rom 13
  ]
  edge [
    source 0
    target 1
    bw 20
  ]
  edge [
    source 1
    target 2
    bw 38
  ]
  edge [
    source 2
    target 3
    bw 18
  ]
  edge [
    source 3
    target 4
    bw 6
  ]
  edge [
    source 4
    target 5
    bw 8
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 5
  ]
  edge [
    source 7
    target 8
    bw 19
  ]
  edge [
    source 8
    target 9
    bw 43
  ]
  edge [
    source 9
    target 10
    bw 49
  ]
]
