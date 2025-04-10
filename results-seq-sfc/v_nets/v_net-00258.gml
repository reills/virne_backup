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
  id 258
  arrival_time 4926.070905844344
  lifetime 620.5219262640409
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 27
    gpu 21
    rom 31
  ]
  node [
    id 1
    label "1"
    cpu 38
    gpu 37
    rom 10
  ]
  node [
    id 2
    label "2"
    cpu 46
    gpu 4
    rom 46
  ]
  node [
    id 3
    label "3"
    cpu 5
    gpu 20
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 40
    gpu 40
    rom 19
  ]
  node [
    id 5
    label "5"
    cpu 23
    gpu 6
    rom 46
  ]
  node [
    id 6
    label "6"
    cpu 39
    gpu 10
    rom 36
  ]
  node [
    id 7
    label "7"
    cpu 32
    gpu 19
    rom 4
  ]
  node [
    id 8
    label "8"
    cpu 3
    gpu 49
    rom 41
  ]
  node [
    id 9
    label "9"
    cpu 19
    gpu 17
    rom 12
  ]
  node [
    id 10
    label "10"
    cpu 44
    gpu 18
    rom 46
  ]
  node [
    id 11
    label "11"
    cpu 2
    gpu 26
    rom 34
  ]
  edge [
    source 0
    target 1
    bw 11
  ]
  edge [
    source 1
    target 2
    bw 5
  ]
  edge [
    source 2
    target 3
    bw 22
  ]
  edge [
    source 3
    target 4
    bw 43
  ]
  edge [
    source 4
    target 5
    bw 32
  ]
  edge [
    source 5
    target 6
    bw 30
  ]
  edge [
    source 6
    target 7
    bw 23
  ]
  edge [
    source 7
    target 8
    bw 16
  ]
  edge [
    source 8
    target 9
    bw 2
  ]
  edge [
    source 9
    target 10
    bw 50
  ]
  edge [
    source 10
    target 11
    bw 21
  ]
]
