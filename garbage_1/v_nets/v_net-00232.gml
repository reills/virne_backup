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
  id 232
  arrival_time 4218.489143015282
  lifetime 1717.898656397844
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 37
    gpu 2
    rom 22
  ]
  node [
    id 1
    label "1"
    cpu 19
    gpu 46
    rom 42
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 29
    rom 35
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 35
    rom 12
  ]
  node [
    id 4
    label "4"
    cpu 4
    gpu 6
    rom 5
  ]
  node [
    id 5
    label "5"
    cpu 20
    gpu 40
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 28
    gpu 28
    rom 8
  ]
  node [
    id 7
    label "7"
    cpu 48
    gpu 10
    rom 41
  ]
  node [
    id 8
    label "8"
    cpu 28
    gpu 7
    rom 24
  ]
  node [
    id 9
    label "9"
    cpu 21
    gpu 15
    rom 14
  ]
  node [
    id 10
    label "10"
    cpu 43
    gpu 7
    rom 11
  ]
  node [
    id 11
    label "11"
    cpu 37
    gpu 46
    rom 37
  ]
  edge [
    source 0
    target 1
    bw 8
  ]
  edge [
    source 1
    target 2
    bw 21
  ]
  edge [
    source 2
    target 3
    bw 50
  ]
  edge [
    source 3
    target 4
    bw 41
  ]
  edge [
    source 4
    target 5
    bw 9
  ]
  edge [
    source 5
    target 6
    bw 43
  ]
  edge [
    source 6
    target 7
    bw 0
  ]
  edge [
    source 7
    target 8
    bw 49
  ]
  edge [
    source 8
    target 9
    bw 6
  ]
  edge [
    source 9
    target 10
    bw 20
  ]
  edge [
    source 10
    target 11
    bw 39
  ]
]
