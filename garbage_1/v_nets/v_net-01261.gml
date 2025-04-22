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
  id 1261
  arrival_time 26377.19801291958
  lifetime 1075.5112948078654
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 11
    gpu 34
    rom 35
  ]
  node [
    id 1
    label "1"
    cpu 2
    gpu 30
    rom 21
  ]
  node [
    id 2
    label "2"
    cpu 38
    gpu 8
    rom 27
  ]
  node [
    id 3
    label "3"
    cpu 34
    gpu 39
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 24
    gpu 26
    rom 46
  ]
  node [
    id 5
    label "5"
    cpu 19
    gpu 19
    rom 35
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 23
    rom 42
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 5
    rom 28
  ]
  node [
    id 8
    label "8"
    cpu 42
    gpu 39
    rom 47
  ]
  node [
    id 9
    label "9"
    cpu 24
    gpu 44
    rom 44
  ]
  edge [
    source 0
    target 1
    bw 29
  ]
  edge [
    source 1
    target 2
    bw 26
  ]
  edge [
    source 2
    target 3
    bw 27
  ]
  edge [
    source 3
    target 4
    bw 18
  ]
  edge [
    source 4
    target 5
    bw 38
  ]
  edge [
    source 5
    target 6
    bw 10
  ]
  edge [
    source 6
    target 7
    bw 33
  ]
  edge [
    source 7
    target 8
    bw 26
  ]
  edge [
    source 8
    target 9
    bw 27
  ]
]
