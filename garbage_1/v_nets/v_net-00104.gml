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
  id 104
  arrival_time 2001.6845116611285
  lifetime 1784.478433840533
  num_nodes 11
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 24
    rom 5
  ]
  node [
    id 1
    label "1"
    cpu 31
    gpu 6
    rom 39
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 6
    rom 34
  ]
  node [
    id 3
    label "3"
    cpu 18
    gpu 45
    rom 6
  ]
  node [
    id 4
    label "4"
    cpu 42
    gpu 34
    rom 31
  ]
  node [
    id 5
    label "5"
    cpu 50
    gpu 29
    rom 43
  ]
  node [
    id 6
    label "6"
    cpu 2
    gpu 14
    rom 41
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 36
    rom 16
  ]
  node [
    id 8
    label "8"
    cpu 12
    gpu 2
    rom 17
  ]
  node [
    id 9
    label "9"
    cpu 17
    gpu 23
    rom 17
  ]
  node [
    id 10
    label "10"
    cpu 6
    gpu 7
    rom 5
  ]
  edge [
    source 0
    target 1
    bw 50
  ]
  edge [
    source 1
    target 2
    bw 16
  ]
  edge [
    source 2
    target 3
    bw 17
  ]
  edge [
    source 3
    target 4
    bw 19
  ]
  edge [
    source 4
    target 5
    bw 17
  ]
  edge [
    source 5
    target 6
    bw 27
  ]
  edge [
    source 6
    target 7
    bw 21
  ]
  edge [
    source 7
    target 8
    bw 14
  ]
  edge [
    source 8
    target 9
    bw 50
  ]
  edge [
    source 9
    target 10
    bw 48
  ]
]
