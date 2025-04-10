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
  id 674
  arrival_time 14357.289922032653
  lifetime 249.47702148614823
  num_nodes 9
  type "path"
  node [
    id 0
    label "0"
    cpu 6
    gpu 49
    rom 25
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 25
    rom 41
  ]
  node [
    id 2
    label "2"
    cpu 28
    gpu 47
    rom 37
  ]
  node [
    id 3
    label "3"
    cpu 40
    gpu 24
    rom 11
  ]
  node [
    id 4
    label "4"
    cpu 48
    gpu 14
    rom 0
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 25
    rom 30
  ]
  node [
    id 6
    label "6"
    cpu 45
    gpu 19
    rom 34
  ]
  node [
    id 7
    label "7"
    cpu 39
    gpu 29
    rom 31
  ]
  node [
    id 8
    label "8"
    cpu 35
    gpu 22
    rom 23
  ]
  edge [
    source 0
    target 1
    bw 32
  ]
  edge [
    source 1
    target 2
    bw 47
  ]
  edge [
    source 2
    target 3
    bw 45
  ]
  edge [
    source 3
    target 4
    bw 7
  ]
  edge [
    source 4
    target 5
    bw 33
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 49
  ]
  edge [
    source 7
    target 8
    bw 46
  ]
]
