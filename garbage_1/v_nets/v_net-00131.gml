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
  id 131
  arrival_time 2317.7000037072285
  lifetime 67.56088195229785
  num_nodes 12
  type "path"
  node [
    id 0
    label "0"
    cpu 34
    gpu 17
    rom 33
  ]
  node [
    id 1
    label "1"
    cpu 0
    gpu 5
    rom 3
  ]
  node [
    id 2
    label "2"
    cpu 27
    gpu 23
    rom 12
  ]
  node [
    id 3
    label "3"
    cpu 21
    gpu 39
    rom 30
  ]
  node [
    id 4
    label "4"
    cpu 11
    gpu 41
    rom 41
  ]
  node [
    id 5
    label "5"
    cpu 3
    gpu 18
    rom 8
  ]
  node [
    id 6
    label "6"
    cpu 44
    gpu 35
    rom 17
  ]
  node [
    id 7
    label "7"
    cpu 6
    gpu 45
    rom 20
  ]
  node [
    id 8
    label "8"
    cpu 26
    gpu 16
    rom 0
  ]
  node [
    id 9
    label "9"
    cpu 20
    gpu 39
    rom 9
  ]
  node [
    id 10
    label "10"
    cpu 0
    gpu 9
    rom 10
  ]
  node [
    id 11
    label "11"
    cpu 25
    gpu 38
    rom 14
  ]
  edge [
    source 0
    target 1
    bw 28
  ]
  edge [
    source 1
    target 2
    bw 23
  ]
  edge [
    source 2
    target 3
    bw 5
  ]
  edge [
    source 3
    target 4
    bw 32
  ]
  edge [
    source 4
    target 5
    bw 44
  ]
  edge [
    source 5
    target 6
    bw 47
  ]
  edge [
    source 6
    target 7
    bw 46
  ]
  edge [
    source 7
    target 8
    bw 31
  ]
  edge [
    source 8
    target 9
    bw 8
  ]
  edge [
    source 9
    target 10
    bw 26
  ]
  edge [
    source 10
    target 11
    bw 25
  ]
]
