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
  id 356
  arrival_time 6699.855802065237
  lifetime 891.9203825624178
  num_nodes 7
  type "path"
  node [
    id 0
    label "0"
    cpu 28
    gpu 1
    rom 7
  ]
  node [
    id 1
    label "1"
    cpu 43
    gpu 34
    rom 9
  ]
  node [
    id 2
    label "2"
    cpu 8
    gpu 45
    rom 2
  ]
  node [
    id 3
    label "3"
    cpu 45
    gpu 18
    rom 38
  ]
  node [
    id 4
    label "4"
    cpu 31
    gpu 46
    rom 22
  ]
  node [
    id 5
    label "5"
    cpu 18
    gpu 26
    rom 42
  ]
  node [
    id 6
    label "6"
    cpu 37
    gpu 17
    rom 45
  ]
  edge [
    source 0
    target 1
    bw 41
  ]
  edge [
    source 1
    target 2
    bw 49
  ]
  edge [
    source 2
    target 3
    bw 21
  ]
  edge [
    source 3
    target 4
    bw 4
  ]
  edge [
    source 4
    target 5
    bw 37
  ]
  edge [
    source 5
    target 6
    bw 34
  ]
]
