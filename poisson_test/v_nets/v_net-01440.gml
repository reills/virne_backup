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
  id 1440
  arrival_time 30224.629693321167
  lifetime 927.0679535033238
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 46
    gpu 14
    rom 32
  ]
  node [
    id 1
    label "1"
    cpu 45
    gpu 16
    rom 28
  ]
  node [
    id 2
    label "2"
    cpu 37
    gpu 41
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 35
    rom 35
  ]
  node [
    id 4
    label "4"
    cpu 27
    gpu 24
    rom 33
  ]
  node [
    id 5
    label "5"
    cpu 37
    gpu 16
    rom 47
  ]
  node [
    id 6
    label "6"
    cpu 11
    gpu 24
    rom 35
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 28
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 29
    rom 16
  ]
  node [
    id 9
    label "9"
    cpu 47
    gpu 25
    rom 37
  ]
  node [
    id 10
    label "10"
    cpu 44
    gpu 41
    rom 41
  ]
  node [
    id 11
    label "11"
    cpu 45
    gpu 36
    rom 12
  ]
  edge [
    source 0
    target 1
    bw 39
  ]
  edge [
    source 1
    target 2
    bw 45
  ]
  edge [
    source 2
    target 3
    bw 43
  ]
  edge [
    source 3
    target 4
    bw 35
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 18
  ]
  edge [
    source 6
    target 7
    bw 29
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 41
  ]
  edge [
    source 9
    target 10
    bw 22
  ]
  edge [
    source 10
    target 11
    bw 8
  ]
]
