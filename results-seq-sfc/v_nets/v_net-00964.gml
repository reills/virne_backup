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
  id 964
  arrival_time 20488.30904686581
  lifetime 36.971588552630955
  num_nodes 10
  type "path"
  node [
    id 0
    label "0"
    cpu 30
    gpu 41
    rom 2
  ]
  node [
    id 1
    label "1"
    cpu 7
    gpu 33
    rom 37
  ]
  node [
    id 2
    label "2"
    cpu 9
    gpu 20
    rom 31
  ]
  node [
    id 3
    label "3"
    cpu 46
    gpu 34
    rom 32
  ]
  node [
    id 4
    label "4"
    cpu 30
    gpu 11
    rom 25
  ]
  node [
    id 5
    label "5"
    cpu 26
    gpu 13
    rom 2
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 43
    rom 4
  ]
  node [
    id 7
    label "7"
    cpu 4
    gpu 29
    rom 18
  ]
  node [
    id 8
    label "8"
    cpu 9
    gpu 31
    rom 49
  ]
  node [
    id 9
    label "9"
    cpu 8
    gpu 5
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 19
  ]
  edge [
    source 1
    target 2
    bw 50
  ]
  edge [
    source 2
    target 3
    bw 29
  ]
  edge [
    source 3
    target 4
    bw 11
  ]
  edge [
    source 4
    target 5
    bw 1
  ]
  edge [
    source 5
    target 6
    bw 45
  ]
  edge [
    source 6
    target 7
    bw 34
  ]
  edge [
    source 7
    target 8
    bw 30
  ]
  edge [
    source 8
    target 9
    bw 36
  ]
]
